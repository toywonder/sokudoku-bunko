# frozen_string_literal: true

require 'rails_helper'

describe Api::BooksController, type: :controller do
  let!(:books) { create_list(:book, 2) }

  describe 'GET index' do
    it 'works' do
      get :index, format: :json
      expect(response.status).to eq(200)
      expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
    end
  end

  describe 'get #show' do
    it 'work' do
      get :show, params: { title: books.first.title }, format: :json
      expect(assigns(:book)).to eq(books.first)
      expect(response.status).to eq(200)
    end
    context 'recode_not_found' do
      it 'work' do
        get :show, params: { title: 'hoge' }, format: :json
        expect(assigns(:book)).to eq(nil)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'get #search' do
    let!(:book) { create(:book, title: '羅生門') }
    it 'work' do
      get :search, params: { title: '生門' }, format: :json
      expect(assigns(:books).first.title).to eq(book.title)
      expect(response.status).to eq(200)
    end
    context 'recode_not_found' do
      it 'work' do
        get :search, params: { title: 'hoge' }, format: :json
        expect(assigns(:book)).to eq(nil)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'get #ranking' do
    it 'work' do
      get :ranking, format: :json
      expect(response.status).to eq(200)
      expect(assigns(:books).pluck(:id)).to match_array(Ranking.order(rank: :asc).pluck(:book_id))
    end
  end
end
