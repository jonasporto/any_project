class ApplicationController < ActionController::Base
  include ResponseErrors

  # Nothing to update, only a hack for ensuring of having a session loaded,
  # Otherwise for the first interaction the session would be: #<ActionDispatch::Request::Session not yet loaded>
  def ensure_session_loaded!
    session.update({}) unless session.loaded?
  end
end
