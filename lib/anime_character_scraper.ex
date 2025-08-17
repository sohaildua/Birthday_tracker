defmodule AnimeCharacter do
  import DateUtils
  import BirthdayTrackerMongoData
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://www.animecharactersdatabase.com/birthdays.php"

  @impl Crawly.Spider
  def init(opts) do
    mongo_conn = Keyword.get(opts, :mongo_conn)

    [
      start_urls: [
        "https://www.animecharactersdatabase.com/birthdays.php?theday=#{day()}&themonth=#{month()}",
        "https://www.animecharactersdatabase.com/birthdays.php?x=30&theday=#{day()}&themonth=#{month()}"
      ],
      # <-- this is crucial
      mongo_conn: mongo_conn
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    mongo_conn = Application.get_env(:birthday_tracker, :mongo_conn)
    Logger.info("Mongo conn inside spider: #{inspect(mongo_conn)}")

    {:ok, document} = Floki.parse_document(response.body)
    product_items = Floki.find(document, "div.outframe .zero .zero")

    dec =
      Enum.flat_map(product_items, fn x ->
        birth_date = month() <> " " <> day()
        url_imgs = Floki.find(x, "li .roll-in-once.thumb150") |> Floki.attribute("src")

        character_names =
          Floki.find(x, "li .tile1bottom > div:first-child")
          |> Enum.map(&Floki.text/1)

        anime_names =
          Floki.find(x, "li .tile1bottom > div:nth-child(2)")
          |> Enum.map(&Floki.text/1)

        Enum.zip([url_imgs, character_names, anime_names])
        |> Enum.map(fn {url_img, character_name, anime_name} ->
          %{
            birth_date: birth_date,
            url_img: url_img,
            character_name: character_name,
            anime_name: anime_name
          }
        end)
      end)

    insert_all(mongo_conn, "web_anime_characters",dec)
    # For demo, just return an empty item list and no new requests
    %Crawly.ParsedItem{
      items: dec
    }
  end
end
