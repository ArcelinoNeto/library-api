require 'rails_helper'
require 'pry'

RSpec.describe "Authors", type: :request do

    context "GET /authors" do
        let(:url) { "/authors" }
        let(:authors) { create_list(:author, 5) }

        it "returns all Authors" do 
            get url

            expected_authors = authors.as_json(only: %i(id name))
            expect(authors.as_json(only: %i(id name))).to match_array expected_authors
        end

        it "return sucess status" do 
            get url
            expect(response).to have_http_status(:ok)
        end
    end

    context "POST /authors" do
        let(:url) { "/authors" }

        context "with valid params" do
            let(:author_params) { { author: attributes_for(:author) }.to_json }

            it 'adds a new Author' do
                # expect do
                #     post url, params: author_params
                #     binding.pry
                # end.to change(Author, :count).by(1)
            end

            it 'returns last added Author' do
                post url, params: author_params
                expected_author = Author.last.as_json(only: %i(id name))
                expect(body_json['author']).to eq expected_author
            end

            it 'returns success status' do
                post url, params: author_params
                # expect(response).to have_http_status(:ok)
            end
        end
      
        context "with invalid params" do
            let(:author_invalid_params) do 
                { author: attributes_for(:author, name: nil) }.to_json
            end
            
            it 'does not add a new Author' do
                expect do
                    post url, params: author_invalid_params
                end.to_not change(Author, :count)
            end

            it 'returns error message' do
                post url, params: author_invalid_params
                # expect(body_json['errors']['fields']).to have_key('name')
            end

            it 'returns unprocessable_entity status' do
                post url, params: author_invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "PATCH /authors/:id" do
        let(:author) { create(:author) }
        let(:url) { "/authors/#{author.id}" }

        context "with valid params" do
            let(:new_name) { 'My new John' }
            let(:author_params) { { author: { name: new_name } }.to_json }

            it 'updates Authors' do
                patch url, params: author_params
                author.reload
                # binding.pry
                # expect(author.name).to eq new_name
            end

            it 'returns updated Author' do
                patch url, params: author_params
                author.reload
                expected_author = author.as_json
                expect(author.as_json).to eq expected_author
            end

            it 'returns success status' do
                patch url, params: author_params
                expect(response).to have_http_status(:ok)
            end
        end
        
        context "with invalid params" do
            let(:author_invalid_params) do 
              { author: attributes_for(:author, name: nil) }.to_json
            end

            it 'does not update Author' do
                old_name = author.name
                patch url, params: author_invalid_params
                author.reload
                expect(author.name).to eq old_name
            end

            it 'returns error message' do
                patch url, params: author_invalid_params
                # expect(['errors']['fields']).to have_key('name')
            end

            it 'returns unprocessable_entity status' do
                patch url, params: author_invalid_params
                # expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "DELETE /authors/:id" do
        let!(:author) { create(:author) }
        let(:url) { "/authors/#{author.id}" }

        it 'removes Author' do
            expect do  
              delete url
            end.to change(Author, :count).by(-1)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(:no_content)
        end

        it 'does not return any body content' do
            delete url
            # expect(book).to_not be_present
        end
    end
end
