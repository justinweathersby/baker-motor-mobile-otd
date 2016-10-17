class PushNotification < ApplicationRecord
  belongs_to :user
  after_create :upload_notification_to_ionic

  validates :message, presence: true
  validates :tokens, presence: true

  # attribute :tokens, :string, array: true
  serialize :tokens, Array

private
  def upload_notification_to_ionic
    puts self.tokens.to_json


    params = {
      "tokens" => self.tokens,
      "profile" => "justin_production",
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
    req['Authorization'] = ENV['IONIC_API_TOKEN']
    req.body = params.to_json
    res = https.request(req)
    puts res.body
  end
end
