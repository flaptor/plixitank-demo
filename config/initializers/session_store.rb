# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_plixi_session',
  :secret      => '065a6419cbc961046e107eeb8c7f313b3becc7b85dbef1b47520dd6fa2b66381cd5715deaf634b3309efa16ecbdb56c4481453abf6d63cb5672df297b9fb30ea'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
