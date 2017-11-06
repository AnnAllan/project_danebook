module ApplicationHelper

  def navbar_display
    if signed_in_user?
      render partial: "shared/signed_in_navbar"
    else
      render partial: "shared/signed_out_navbar"
    end
  end

end
