RSpec.describe Devise::Models::Async do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  context 'with unchanged model' do
    subject { admin }

    let!(:admin) { create_admin }

    it 'enqueues notifications immediately when the model did not change' do
      expect(ActionMailer::DeliveryJob).to have_been_enqueued
    end

    it 'forwards the correct data to the job' do
      job_data = ActiveJob::Base.queue_adapter.enqueued_jobs.first[:args]
      expected_job_data = ['Devise::Mailer', 'confirmation_instructions', subject.send(:confirmation_token)]

      expect(job_data).to include(*expected_job_data)
    end
  end

  context 'with changed model' do
    subject do
      admin[:username] = "changed_username"
      admin.send_confirmation_instructions

      admin.send(:devise_pending_notifications)
    end

    let!(:admin) { create_admin }

    context 'without saving the model' do
      it 'accumulates a pending notification to be sent after commit' do
        expect(subject).to eq([
          [:confirmation_instructions, [admin.send(:confirmation_token), {}]]
        ])
      end

      it 'does not enqueue another job' do
        expect {
          subject
        }.to_not have_enqueued_job(ActionMailer::DeliveryJob)
      end
    end

    context 'with saving the model' do
      let(:saved_admin) { admin.save }

      it 'accumulates a pending notification to be sent after commit' do
        expect(subject).to eq([
          [:confirmation_instructions, [admin.send(:confirmation_token), {}]]
        ])
      end

      it 'does enqueue another job' do
        subject

        expect {
          saved_admin
        }.to have_enqueued_job(ActionMailer::DeliveryJob)
      end

      it 'forwards the correct data to the job' do
        subject
        saved_admin

        job_data = ActiveJob::Base.queue_adapter.enqueued_jobs.first[:args]
        expected_job_data = ['Devise::Mailer', 'confirmation_instructions', admin.send(:confirmation_token)]

        expect(job_data).to include(*expected_job_data)
      end
    end
  end

  context 'when devise async is disabled' do
    around do |example|
      Devise::Async.enabled = false
      example.run
      Devise::Async.enabled = true
    end

    it 'does not enqueue a job' do
      expect {
        create_admin
      }.to_not have_enqueued_job(ActionMailer::DeliveryJob)
    end

    it 'does not accumulate pending notifications' do
      expect(create_admin.send(:devise_pending_notifications)).to be_empty
    end
  end
end
