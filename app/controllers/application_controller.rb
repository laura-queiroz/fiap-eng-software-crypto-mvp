class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Rendering
  include ActionView::Layouts

  layout "application"
end
