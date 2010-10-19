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
end
