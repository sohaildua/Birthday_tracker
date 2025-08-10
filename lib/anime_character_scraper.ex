defmodule AnimeCharacter do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://www.animecharactersdatabase.com/birthdays.php"

  @impl Crawly.Spider
  def init() do
    [
      start_urls: [
        "https://www.animecharactersdatabase.com/birthdays.php?theday=#{day()}&themonth=#{month()}",
        "https://www.animecharactersdatabase.com/birthdays.php?x=30&theday=#{day()}&themonth=#{month()}"
      ]
    ]
  end

  defp day() do
    today = Date.utc_today()
    Calendar.strftime(today, "%-d")
  end

  defp month() do
    today = Date.utc_today()
    Calendar.strftime(today, "%B")
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)
    product_items = Floki.find(document, "div.outframe .zero .zero")

    dec =
      Enum.map(product_items, fn x ->
        %{
          birth_date: month() <> " " <> day(),
          url_img: Floki.find(x, "li img") |> Floki.attribute("src"),
          character_name:
            Floki.find(x, "li .tile1bottom > div:first-child")
            |> Enum.map(&Floki.text/1),
          anime_name:
            Floki.find(x, "li .tile1bottom > div:nth-child(2)")
            |> Enum.map(&Floki.text/1)
        }
      end)

    Logger.info(dec)

    # For demo, just return an empty item list and no new requests
    %Crawly.ParsedItem{
      items: [],
      requests: []
    }
  end
end
