defmodule DateUtils do
  def day() do
    today = Date.utc_today()
    Calendar.strftime(today, "%-d")
  end

  def month() do
    today = Date.utc_today()
    Calendar.strftime(today, "%B")
  end
end
