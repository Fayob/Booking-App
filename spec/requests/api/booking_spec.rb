require 'swagger_helper'

RSpec.describe 'Booking App API', type: :request do
  path '/signup' do

    post 'Creates a user' do
      tags 'Register'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          username: { type: :string },
          password: { type: :string }
        },
        required: [ 'name', 'username', 'password' ]
      }

      response '201', 'Signup was successful' do
        let(:user) { { name: 'John Doe', username: 'doe1', password: 'password123' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'John Doe' } }
        run_test!
      end
    end
  end

  path '/login' do

    post 'Login a user' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: [ 'username', 'password' ]
      }

      response '200', 'Login successfully' do
        let(:user) { { username: 'doe1', password: 'password123' } }
        run_test!
      end

      response '404', 'wrong credential provided' do
        let(:user) { { username: 'doe1', password: '' } }
        run_test!
      end
    end
  end

  path '/coaches' do

    get 'Retrieves all coaches' do
      tags 'Coaches'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', [
        {id: 1, name: 'John doe', image: 'https//image.png', description: 'A software developer', city: 'Berlin'},
        {id: 1, name: 'Rick jean', image: 'https//image.png', description: 'A frontend developer', city: 'London'},
        ] do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string }
            image: { type: :string }
            city: { type: :string }
          },
          required: [ 'id', 'title', 'description', 'image', 'city' ]

        let(:id) { Blog.create(title: 'foo', content: 'bar').id }
        run_test!
      end

      response '404', 'Something went wrong' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  # path '/blogs/{id}' do

  #   get 'Retrieves a blog' do
  #     tags 'Blogs', 'Another Tag'
  #     produces 'application/json', 'application/xml'
  #     parameter name: :id, in: :path, type: :string
  #     request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

  #     response '200', 'blog found' do
  #       schema type: :object,
  #         properties: {
  #           id: { type: :integer },
  #           title: { type: :string },
  #           content: { type: :string }
  #         },
  #         required: [ 'id', 'title', 'content' ]

  #       let(:id) { Blog.create(title: 'foo', content: 'bar').id }
  #       run_test!
  #     end

  #     response '404', 'blog not found' do
  #       let(:id) { 'invalid' }
  #       run_test!
  #     end

  #     response '406', 'unsupported accept header' do
  #       let(:'Accept') { 'application/foo' }
  #       run_test!
  #     end
  #   end
  # end
end
