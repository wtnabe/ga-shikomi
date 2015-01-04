module GACli
  module GaDouble
    def multi_rows
      {
        "columnHeaders"=>[
          {
            "name"       => "ga:deviceCategory",
            "columnType" => "DIMENSION",
            "dataType"   => "STRING"
          },
          {
            "name"       => "ga:pageviews",
            "columnType" => "METRIC",
            "dataType"   => "INTEGER"},
          {
            "name"       => "ga:sessions",
            "columnType" => "METRIC",
            "dataType"   => "INTEGER"
          },
          {
            "name"       => "ga:pageviewsPerSession",
            "columnType" => "METRIC",
            "dataType"   => "FLOAT"
          },
          {
            "name"       => "ga:goal1Value",
            "columnType" => "METRIC",
            "dataType"   => "CURRENCY"
          }
        ],
        "totalsForAllResults" => {
          "ga:pageviews"           => "4090",
          "ga:sessions"            => "3649",
          "ga:pageviewsPerSession" => "1.1208550287750068",
          "ga:goal1Value"          => "0.0"
        },
        "rows" => [
          ["desktop", "3846", "3442", "1.1173736199883788", "0.0"],
          ["mobile",  "172",  "141",  "1.2198581560283688", "0.0"],
          ["tablet",  "72",   "66",   "1.0909090909090908", "0.0"]
        ]
      }
    end
  end
end
