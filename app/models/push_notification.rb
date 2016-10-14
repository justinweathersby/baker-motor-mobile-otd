class PushNotification < ApplicationRecord
  belongs_to :user
  after_create :upload_notification_to_ionic

  validates :message, presence: true
  validates :tokens, presence: true

private
  def upload_notification_to_ionic
    params = {
      "tokens" => [self.tokens],
      "profile" => "justin_dev",
      "notification":{
        "message": self.message,
        "android":{
          "title": "Baker Motor Company"
        },
         "ios": {
              "title": "Baker Motor Company"
            }
      }
    }

    uri = URI.parse('https://api.ionic.io/push/notifications')
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req['Content-Type'] = 'application/json'
    req['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkYzU3YTdlZC1iODk2LTQ2ZjEtOTNmMC1kZDQwMmNmZThmZjIifQ.PWrbouLNCPsQeny1mVxGdEUvIwRb4vAvQVqAS--7Vjk'
    req.body = params.to_json
    res = https.request(req)
    puts res.body
  end
end