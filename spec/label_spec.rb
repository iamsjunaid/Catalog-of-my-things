require_relative '../classes/book/label'
require_relative '../classes/item'

describe Label do
  describe 'unit tests for \'Label\' class' do
    before(:each) do
      # set the params to create a Label instance
      @label_params_req = {
        name: 'test label',
        title: 'book label',
        color: 'red'
      }
      @label_params_id = {
        id: 1,
        name: 'test label'
      }
      @new_label_req = Label.new(@label_params_req)
      @new_label_id = Label.new(@label_params_id)

      @label_instance = instance_double(Label)

      # create an Item instance
      item_params_id = {
        id: 1,
        publish_date: '2023-08-01'
      }
      @new_item = Item.new(item_params_id)
    end

    context 'when creating a new \'Label\'' do
      it 'should create an instance of \'Label\' class' do
        expect(@new_label_req).to be_an_instance_of(Label)
        expect(@new_label_id).to be_an_instance_of(Label)
      end

      it 'should have a valid \'id\' not \'nil\' but an \'Integer\'' do
        expect(@new_label_req.id).not_to be_nil
        expect(@new_label_id.id).not_to be_nil
        expect(@new_label_req.id).to be_an_instance_of(Integer)
        expect(@new_label_id.id).to be_an_instance_of(Integer)
      end

      it 'should have a valid \'title\' not \'nil\' but a \'String\'' do
        expect(@new_label_req.title).not_to be_nil
        expect(@new_label_req.color).not_to be_nil
        expect(@new_label_req.title).to be_an_instance_of(String)
        expect(@new_label_req.title).to be_an_instance_of(String)
        expect(@new_label_req.color).to be_an_instance_of(String)
        expect(@new_label_req.color).to be_an_instance_of(String)
      end

      it 'should not have any \'items\'' do
        expect(@new_label_req.items).to be_empty
        expect(@new_label_id.items).to be_empty
        expect(@new_label_req.items).to be_an_instance_of(Array)
        expect(@new_label_id.items).to be_an_instance_of(Array)
      end
    end

    context '#add_item method' do
      it 'should exists' do
        expect(@new_label_req).to respond_to(:add_item)
      end

      it 'should receive one parameter as input, an \'Item\' instance' do
        allow(@label_instance).to receive(:add_item).with(instance_of(Item)).exactly(1)
        @label_instance.add_item(@new_item)
      end

      it 'should add the input \'Item\' to the collection of \'items\'' do
        @new_label_req.add_item(@new_item)
        expect(@new_label_req.items).to include(@new_item)
      end

      it 'should add only once the input \'Item\' to th collection of \'items\'' do
        @new_label_req.add_item(@new_item)
        @new_label_req.add_item(@new_item)
        @new_label_req.add_item(@new_item)
        expect(@new_label_req.items).to include(@new_item)
        expect(@new_label_req.items.size).to eql(1)
      end

      it 'should set \'Label\' instance as a property of the input \'Item\' instance' do
        @new_label_req.add_item(@new_item)
        expect(@new_item.label).to be(@new_label_req)
      end
    end
  end
end
