module ApplicationHelper
  def logo(size = 'h2')
    link_to(root_path, class: "logo #{size}") do
      "<i class=\'bi bi-alipay\'></i> JKZQUIZ".html_safe
    end
  end

  def account_page?
    current_page?(edit_user_registration_path)
  end

  def format_time(time)
    time.strftime("%m/%d/%Y %I:%M %p")
  end

  def render_flash_stream
    turbo_stream.update("flash", partial: "shared/flash", locals: { flash: flash })
  end
end
