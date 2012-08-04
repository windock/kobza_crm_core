require 'kobza_crm/domain/communication_thread'

module KobzaCRM module Domain module Test
  describe CommunicationThread do
    it 'has brief description' do
      subject.brief_description = 'asdf'
      subject.brief_description.should == 'asdf'
    end

    it 'has topic name' do
      subject.topic_name = 'qwer'
      subject.topic_name = 'qwer'
    end
  end
end end end
