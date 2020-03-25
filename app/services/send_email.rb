class SendEmail
    def initialize
        config
    end

    def deliver(receiver, template_id, subject)
        Mailjet::Send.create(messages: [{
            'From'=> {
                'Email'=> "ricardo@hardquarters.com",
                'Name'=> "Preserve"
            },
            'To'=> [
                {
                'Email'=> receiver,
                'Name'=> 'passenger 1'
                }
            ],
            'TemplateID'=> template_id,
            'TemplateLanguage'=> true,
            'Subject'=> subject
        }])
    end
    private
    def config
        Mailjet.configure do |config|
            config.api_key = ENV["MAILJET_API_KEY"]
            config.secret_key = ENV["MAILJET_SECRET_KEY"]
            config.api_version = "v3.1"
        end
    end
  end