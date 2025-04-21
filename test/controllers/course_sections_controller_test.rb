require "test_helper"

class CourseSectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get course_sections_create_url
    assert_response :success
  end
end
