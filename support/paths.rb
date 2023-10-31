# features/support/paths.rb

module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the home page/
      root_path

    when /the item list page/
      items_path

    #when /the Login page/
      #new_user_session_path

    when /the Log in page/
      new_user_session_path

    when /the sign up page/
      new_user_registration_path

    when /the Profile page/
      user_path(User.find_by_email('test@example.com'))

    when /the My Items page/
      user_my_items_path(User.find_by_email('test@example.com'))

    when /the Logout page/
      destroy_user_session_path

    when /the New Item page/
      new_item_path


    when /the Edit User page/
      edit_user_registration_path
      #edit_user_registration_path || root_path

    when /the cancel account page/
      destroy_user_session_path

    when /the password reset page/
      new_user_password_path

    when /the item details page/
      item_path(Item.last)

    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)
