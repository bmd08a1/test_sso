require 'uri'
require 'net/http'

class ApplicationController < ActionController::Base
  def index
    employee_id = params[:employee_id]
    business_id = params[:business_id]

    uri = URI("http://localhost:3000/api/v3/sso/generate_embed_url_token")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    request['Eh-Api-Key'] = '6deaaba4-35f3-4fb1-a0aa-9f5274f5494b'
    request.body = {
      organisation_external_id: business_id,
      member_external_id: employee_id,
      target_page_name: 'list_pay_categories'
    }.to_json

    response = JSON.parse(http.request(request).body)
    embed_url_token = response['data']['token']

    @embed_url = "http://localhost:3000/sso/embed?token=#{embed_url_token}"
  end
end