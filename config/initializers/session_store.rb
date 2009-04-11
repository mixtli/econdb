# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_econdb_session',
  :secret      => 'fd1ec3ebb9130a8cf68e9a5fba004c4761083403fa102b00f9bef41e59a8f0fca450a420ad7bc75bdff9167acf0f8a801118f3c2e304e5f3ee79241b5570378b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
