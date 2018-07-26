module ApplicationHelper
  def full_title page_title = ""
    base_title = Settings.title
    page_title ||= base_title
  end
end
