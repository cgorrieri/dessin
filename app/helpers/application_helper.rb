module ApplicationHelper
  def are_friends?(user1, user2)
    if Friend.find_by_user_id_and_fuser_id(user1.id, user2.id)
      return true
    else
      return false
    end
  end

  def already_requested_to?(user1, user2)
    if FriendRequest.find_by_sender_id_and_reciever_id(user1, user2)
      return true
    else
      return false
    end
  end

  def set_date_format(date,format)
    return date.strftime(format)
  end

  def get_time(date)
    return date.strftime("%H\:%M")
  end

  def devise_errors!
    format_errors(resource)
  end

  def form_errors!(form)
    format_errors(form)
  end

  def format_errors(object)
    return "" if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = "#{pluralize(object.errors.count, "erreur")}"

    html = <<-HTML
<div id="error_explanation">
<h3>#{sentence}</h3>
<ul>#{messages}</ul>
</div>
    HTML

    html.html_safe
  end

  def format_keywords(keywords_string)
    keywords = []
    keywords_string.split(',').each do |keyword|
      keywords.push(I18n.t("keywords.#{keyword}"))
    end
    return keywords * ', '
  end
end
