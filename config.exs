import Config

config :logger, level: :debug
config :crawly, log_level: :debug

config :crawly,
  closespider_timeout: 10,
  concurrent_requests_per_domain: 8,
  closespider_itemcount: 100,
  middlewares: [
    Crawly.Middlewares.DomainFilter,
    Crawly.Middlewares.UniqueRequest,
    {Crawly.Middlewares.UserAgent, user_agents: ["Crawly Bot"]}
  ],
  pipelines: [
    {Crawly.Pipelines.WriteToFile, extension: "jl", folder: "/tmp"}
  ],
  parsers: [
    {Crawly.Parsers.ExtractRequests, selector: "button"}
  ]
