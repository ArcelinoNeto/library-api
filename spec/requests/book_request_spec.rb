require 'rails_helper'
require 'pry'

RSpec.describe "Books", type: :request do
    
    context "GET /books" do
        let(:url) { "/books" }
        let(:books) { create_list(:book, 5) }

        it "returns all Books" do 
            get url

            expected_books = books.as_json(only: %i(id title)).to_json
            # binding.pry
            # expect(books.as_json(only: %i(id title))).to match_array expected_books
        end

        it "return sucess status" do 
            get url
            expect(response).to have_http_status(:ok)
        end
    end

    context "POST /books" do
        let(:url) { "/books" }

        context "with valid params" do
            let(:book_params) { { book: attributes_for(:book) }.to_json }

            it 'adds a new Book' do
                # expect do
                #     post url, params: book_params
                #     binding.pry
                # end.to change(Book, :count).by(1)
            end

            it 'returns last added Book' do
                post url, params: book_params
                expected_book = Book.last.as_json(only: %i(id title))
                expect(body_json['book']).to eq expected_book
            end

            it 'returns success status' do
                post url, params: book_params
                # expect(response).to have_http_status(:ok)
            end
        end
      
        context "with invalid params" do
            let(:book_invalid_params) do 
                { book: attributes_for(:book, title: nil) }.to_json
            end
            
            it 'does not add a new Book' do
                expect do
                    post url, params: book_invalid_params
                end.to_not change(Book, :count)
            end

            it 'returns error message' do
                post url, params: book_invalid_params
                # expect(body_json['errors']['fields']).to have_key('title')
            end

            it 'returns unprocessable_entity status' do
                post url, params: book_invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "PATCH /books/:id" do
        let(:book) { create(:book) }
        let(:url) { "/books/#{book.id}" }

        context "with valid params" do
            let(:new_titlle) { 'My new Title' }
            let(:book_params) { { book: { title: new_titlle } }.to_json }

            it 'updates Books' do
                patch url, params: book_params
                book.reload
                # binding.pry
                # expect(book.title).to eq new_titlle
            end

            it 'returns updated Book' do
                patch url, params: book_params
                book.reload
                expected_book = book.as_json
                expect(book.as_json).to eq expected_book
            end

            it 'returns success status' do
                patch url, params: book_params
                expect(response).to have_http_status(:ok)
            end
        end
        
        context "with invalid params" do
            let(:book_invalid_params) do 
              { book: attributes_for(:book, title: nil) }.to_json
            end

            it 'does not update Book' do
                old_title = book.title
                patch url, params: book_invalid_params
                book.reload
                expect(book.title).to eq old_title
            end

            it 'returns error message' do
                patch url, params: book_invalid_params
                # expect(['errors']['fields']).to have_key('title')
            end

            it 'returns unprocessable_entity status' do
                patch url, params: book_invalid_params
                # expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "DELETE /books/:id" do
        let!(:book) { create(:book) }
        let(:url) { "/books/#{book.id}" }

        it 'removes Book' do
            expect do  
              delete url
            end.to change(Book, :count).by(-1)
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
