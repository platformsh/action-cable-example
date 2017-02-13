class HighlighterWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    uri = URI.parse("https://pygments.simplabs.com/")
    request = Net::HTTP.post_form(uri, lang: message.language, code: message.content)
    message.update_attribute(:content, request.body)
  end
end
