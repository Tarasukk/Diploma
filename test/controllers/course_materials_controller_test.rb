require "test_helper"

class CourseMaterialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get course_materials_new_url
    assert_response :success
  end

  test "should get create" do
    get course_materials_create_url
    assert_response :success
  end
end
