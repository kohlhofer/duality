# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_duality_session',
  :secret      => '1cfdfb4522dcf47d906587e0f830e881435669fbe1798d38778e4d8a9ee4006cf065aad94462ed099142c6d481c1591f722713bde200bf2978c29952250c0ed9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
