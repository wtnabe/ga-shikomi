require 'json'

class EnvStore
  #
  # [param] Hash env
  #
  def initialize(env)
    @env = env
  end

  #
  # [return] Hash
  #
  def load_credentials
    JSON.parse(@env['GOOGLE_API_CREDENTIAL'])
  end

  #
  # [param]  Hash credentials_hash
  # [return] Hash
  #
  def write_credentials(credentials_hash)
    credentials_hash
  end
end
