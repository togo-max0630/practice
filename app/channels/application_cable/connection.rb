module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user


    def connect
      self.current_user = find_verified_user
    end

    pravate
      def find_varified_user
        session_key = cookies.encrypted[Rails.application.config.session_options[:key]]
        verified_id = session_key['warden.user.user.key'][0][0]
        varified_user = User.find_by(id: verified_id)
        return reject_unauthorized_connection unless varified_user
        varified_user
      end
  end
end
