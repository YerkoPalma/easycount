module PagesHelper
  def custom_layout
    signed_in? ?  "dashboard" : "application"
  end
end
