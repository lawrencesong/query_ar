require 'support/active_record/face'
require 'pry'

# A class upon which we can base our query object.
# See ActiveRecord::Face for explanation on usage.
#
class FakeModel < ActiveRecord::Face
  scope :active
end

describe ActiveRecord::Face do

  it "keeps track of class messages received" do
    FakeModel.active.where(name: 'stu').order('name').limit(10).offset(0)
    messages = FakeModel.messages_received
    expect(messages.keys.length).to eq 5
    expect(messages).to include(active: [])
    expect(messages).to include(where:  [{name: 'stu'}])
    expect(messages).to include(order:  ['name'])
    expect(messages).to include(limit:  [10])
    expect(messages).to include(offset: [0])
  end

end