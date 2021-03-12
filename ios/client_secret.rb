require 'jwt'

key_file = '/Users/ducthinh/Desktop/flutter/keydangnhap/AuthKey_2WK32K39Z7.p8'
team_id = 'R75YC7YCWZ'
client_id = 'net.tanphat.chocaycanhservice'
key_id = '2WK32K39Z7'

ecdsa_key = OpenSSL::PKey::EC.new IO.read key_file

headers = {
  'kid' => key_id
}

claims = {
    'iss' => team_id,
    'iat' => Time.now.to_i,
    'exp' => Time.now.to_i + 86400*180,
    'aud' => 'https://appleid.apple.com',
    'sub' => client_id,
}

token = JWT.encode claims, ecdsa_key, 'ES256', headers

puts token
