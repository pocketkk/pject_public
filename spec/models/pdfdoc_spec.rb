require 'spec_helper'
require 'carrierwave/test/matchers'


describe PdfdocUploader do
    include CarrierWave::Test::Matchers

    before do
        PdfdocUploader.enable_processing = true
        @workorder = FactoryGirl.create(:workorder)
        @uploader = PdfdocUploader.new(@workorder, :photo)
        @uploader.store!(File.open(Rails.root.join('public', 'image.pdf')))
    end

    after do
        PdfdocUploader.enable_processing = false
        @uploader.remove!
    end

    it "has a valid factory" do

    end

    context 'the thumb version for iOS' do
        it "should scale down image to be no more than 200 x 200 pixels" do
            @uploader.thumb_safari.should be_no_larger_than(200, 200)
        end
    end

    context 'the thumb version for everything else' do
        it "should scale down image to be no more than 200 x 200 pixels" do
            @uploader.thumb.should be_no_larger_than(200, 200)
        end
    end

end
