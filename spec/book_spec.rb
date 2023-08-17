require_relative '../classes/Book/book'
require_relative '../classes/Book/label'

describe Book do
  describe 'unit tests for \'Book\' class' do
    # params to create a Book instance
    before(:each) do
      book_params_req = {
        publish_date: '2020-01-01',
        cover_state: 'good',
        publisher: 'Unknown'
      }
      @book_req = Book.new(book_params_req)
      book_params_id = {
        id: 999_999,
        publish_date: '2023-08-01',
        cover_state: 'good',
        publisher: 'Unknown'
      }
      @book_id = Book.new(book_params_id)

      # params to create a Label instance
      @label_params_id = {
        id: 99,
        title: 'book label',
        color: 'red'
      }
      @new_label = Label.new(@label_params_id)
    end

    context 'when creating a new \'Book\'' do
      it 'should create an instance of \'Book\' class' do
        expect(@book_req).to be_an_instance_of(Book)
        expect(@book_id).to be_an_instance_of(Book)
      end

      it 'should inherit from \'Item\' class' do
        expect(@book_req).to be_kind_of(Item)
        expect(@book_id).to be_kind_of(Item)
        expect(@book_req.class.superclass).to eql(Item)
        expect(@book_id.class.superclass).to eql(Item)
      end
    end

    context 'when creating a new \'Book\'' do
      it 'should have a valid \'id\' value' do
        expect(@book_req.id).not_to be_nil
        expect(@book_id.id).not_to be_nil
        expect(@book_req.id).to be_an_instance_of(Integer)
        expect(@book_id.id).to be_an_instance_of(Integer)
      end

      it 'should have a valid \'cover_state\' value' do
        expect(@book_req.cover_state).not_to be_nil
        expect(@book_id.cover_state).not_to be_nil
        expect(@book_req.cover_state).to be_kind_of(String)
        expect(@book_id.cover_state).to be_kind_of(String)
      end
    end

    context 'when a \'Label\' is set to a \'Book\'' do
      it '\'Book\' should have a valid \'label\' property' do
        @new_label.add_item(@book_req)
        @new_label.add_item(@book_id)
        expect(@book_req.label).not_to be_nil
        expect(@book_req.label).to be_an_instance_of(Label)
        expect(@book_id.label).not_to be_nil
        expect(@book_id.label).to be_an_instance_of(Label)
      end

      it '\'Book\' should be included in the \'items\' collection of \'Label\'' do
        @new_label.add_item(@book_req)
        @new_label.add_item(@book_id)
        expect(@new_label.items).to include(@book_req)
        expect(@new_label.items).to include(@book_id)
      end
    end

    context '#can_be_archived? method' do
      it 'should exist and be \'private\'' do
        expect(@book_req.private_methods).to include(:can_be_archived?)
        expect(Book.private_instance_methods(false)).to include(:can_be_archived?)
      end

      context 'should return \'true\' if' do
        book1 = Book.new({ publish_date: '2011-01-01', cover_state: 'bad', publisher: 'Unknown' })
        book2 = Book.new({ publish_date: '2021-02-01', cover_state: 'good', publisher: 'Unknown' })
        book3 = Book.new({ publish_date: '2012-01-02', cover_state: 'bad', publisher: 'Unknown' })
        book4 = Book.new({ publish_date: '2022-02-02', cover_state: 'good', publisher: 'Unknown' })

        it 'parent\'s method returns \'true\' OR \'cover_state\' is \'bad\'' do
          expect(book1.send(:can_be_archived?)).to be_truthy
          expect(book3.send(:can_be_archived?)).to be_truthy
        end

        it 'should return \'false\' otherwise' do
          expect(book2.send(:can_be_archived?)).to be_falsy
          expect(book4.send(:can_be_archived?)).to be_falsy
        end
      end
    end
  end
end
