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

  # path '/coaches' do

  #   get 'Retrieves all coaches' do
  #     tags 'Coaches'
  #     produces 'application/json'
  #     # parameter name: :coach, in: :path, type: :string
  #     # request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

  #     # [
  #     #   {id: 1, name: 'John doe', image: 'https//image.png', description: 'A software developer', city: 'Berlin'},
  #     #   {id: 1, name: 'Rick jean', image: 'https//image.png', description: 'A frontend developer', city: 'London'},
  #     # ]
  #     schema: {
  #       type: :object, 
  #       properties: {
  #         id: { type: :integer },
  #         name: { type: :string },
  #         description: { type: :string },
  #         image: { type: :string },
  #         city: { type: :string }
  #       }
  #     }
  #     # { '$ref' => '#/components/schemas/coach' }
  #     # components {
  #       #   schemas {
  #         #     coach {
  #           #       type :object,
  #           #       properties: {
              
  #             #       }
  #             #     }
  #             #   } 
  #             # }  
              
  #             required [ 'id', 'name', 'description', 'image', 'city' ]
  #         response '200', 'Successful Response'  do         

  #       # let(:coach) { Coach.create(name: 'Jean', description: 'Developer', city: 'Lagos') }
  #       run_test!
  #     end

  #     response '404', 'Something went wrong' do
  #       let(:id) { 'invalid' }
  #       run_test!
  #     end

  #     response '406', 'unsupported accept header' do
  #       let(:'Accept') { 'application/foo' }
  #       run_test!
  #     end
  #   end
  # end

  path '/api/v1/coaches' do

    get 'Retrieves all coaches' do
      tags 'Coaches'
      produces 'application/json'
      # parameters name: :coach
      response '200', 'Request was successfully fetched' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!

        #     index do
        #       schemas do
        #         coach type: :object
        #           properties {
        #             id { type :integer }
        #             name { type :string }
        #             description { type :string }
        #             image { type :string }
        #             city { type :string }
        #           }
        #       end
        #     end

        #   run_test!
      end

      # response '404', 'coach not found' do
      #   let(:coach) { 'invalid' }
      #   run_test!
      # end

      # response '406', 'unsupported accept header' do
      #   let(:'Accept') { 'application/foo' }
      #   run_test!
      # end
    end
  end


  # paths:
  #   /coaches:
  #     get:
  #       summary: Retrieves all coaches
  #       responses:
  #         '200':
  #           description: List of coaches
  #           content:
  #             application/json:
  #               schema:
  #                 type: array
  #                 items:
  #                   $ref: '#/components/schemas/coach'
  # components:
  #   schemas:
  #     coach:
  #       type: object
  #       properties:
  #         id:
  #           type: integer
  #         name:
  #           type: string
  #         email:
  #           type: string

  path '/coaches/{id}' do

    get 'Retrieves a coach' do
      tags 'Coaches'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'coach found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            image: { type: :string },
            city: { type: :string },
          },
          required: [ 'id', 'name', 'description', 'image', 'city' ]

        let(:id) { Coach.create(name: 'foo', description: 'Developer', city: 'Lagos').id }
        run_test!
      end

      response '404', 'coach not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/coaches' do

    post 'Add a Coach' do
      tags 'Coaches'
      consumes 'application/json'
      parameter name: :coach, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          image: { type: :string },
          city: { type: :string }
        },
        required: [ 'name', 'description', 'image', 'city' ]
      }

      response '200', 'Coach Created Successfully' do
        let(:coach) { { name: 'doe1', description: 'Developer', image: 'https//image.png', city:'Berlin' } }
        run_test!
      end

      response '404', 'wrong credential provided' do
        let(:coach) { { name: 'doe1', image: 'https//image.png' } }
        run_test!
      end
    end
  end

  path '/coaches/{id}' do

    delete 'Delete a coach' do
      tags 'Coaches'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'coach deleted' do
        schema type: :object,
        properties: {
          id: {type: :string}
        },
          required: [ 'id' ]

        let(:id) { Coach.delete(name: 'foo', description: 'Developer', city: 'Lagos').id }
        run_test!
      end

      response '404', 'coach not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/coaches/{coach_id}/reserves' do

    post 'Reserve a Coach' do
      tags 'Reserves'
      consumes 'application/json'
      parameter name: :reserve, in: :path, schema: {
        type: :object,
        properties: {
          coach_id: { type: :integer }
        },
        required: [ 'coach_id' ]
      }

      response '200', 'Coach Successfully Reserved' do
        let(:coach) { { coach_id: 1 } }
        run_test!
      end

      response '404', 'wrong credential provided' do
        let(:coach) { { coach_id: '' } }
        run_test!
      end
    end
  end

  # path '/coaches/{coach_id}/reserves' do

  #   get 'Retrieves all reserved coaches' do
  #     tags 'Reserves'
  #     produces 'application/json'
  #     parameter name: :coach_id, in: :path, type: :string
  #     response '200', 'Request was successfully fetched' do
  #       schema type: :array,
  #         items: {
  #           '$ref' => '#/index/schemas/coach'
  #           # id: { type: :integer },
  #           # name: { type: :string },
  #           # description: { type: :string },
  #           # image: { type: :string },
  #           # city: { type: :string },
  #         }

  #         index do
  #           schemas do
  #             coach type: :object
  #               properties {
  #                 id { type :integer }
  #                 name { type :string }
  #                 description { type :string }
  #                 image { type :string }
  #                 city { type :string }
  #               }
  #           end
  #         end

  #       run_test!
  #     end

  #     response '404', 'coach not found' do
  #       let(:coach) { 'invalid' }
  #       run_test!
  #     end

  #     response '406', 'unsupported accept header' do
  #       let(:'Accept') { 'application/foo' }
  #       run_test!
  #     end
  #   end
  # end


  path 'coaches/{coach_id}/reserves/{id}' do

    delete 'Delete a coach from reservation list' do
      tags 'Reserves'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :coach_id, in: :path, type: :string

      response '200', 'coach successfully removed from reservation list' do

        let(:id) { Reserve.delete().id }
        let(:coach_id) { Reserve.delete().coach_id }
        run_test!
      end

      response '404', 'coach not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end
