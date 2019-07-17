require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should display new image form' do
    get new_image_path

    assert_response :success
    assert_select 'input#image_url'
  end

  test 'should create new image and respond with redirect' do
    post images_path,
         params: { image: { url: URL_PATH, tag_list: 'nice, fun' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    puts response.body
    assert_select 'a', URL_PATH
    assert_select 'span.badge'
    assert Image.exists? url: URL_PATH
  end

  URL_PATH = 'https://cdn.royalcanin-weshare-online.io/GvqPH2YBIYfdNSoCoAgj/v1/bd18bl-bernese-mountain-dog-adult-standing'.freeze
end
