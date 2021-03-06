require 'spec_helper'

describe 'SodaXmlTeam' do

  subject do
    SodaXmlTeam::Client.new(
      ENV['SODA_USERNAME'], ENV['SODA_PASSWORD']
    )
  end

  describe '.content_finder' do

    let(:input) do
      {
        sandbox: true,
        league_id: 'l.nhl.com',
        team_id: 'l.nhl.com-t.19',
        type: 'schedule-single-team',
        start_datetime: DateTime.parse('2010-01-01 00:00:00 CDT'),
        end_datetime: DateTime.parse('2011-01-01 00:00:00 CDT')
      }
    end
    let(:output) { subject.content_finder(input) }

    it 'has seven items' do
      expect(output.length).to eq 7
    end

    it 'has attributes that match' do
      expect(output[0][:title]).to eq '2010 Nashville Predators Schedule'
      expect(output[0][:link]).to eq 'http://soda.xmlteam.com/api-trial/getDocuments?doc-ids=xt.10875359-nas-sked'
      expect(output[0][:document_id]).to eq 'xt.10875359-nas-sked'
      expect(output[0][:date]).to eq DateTime.parse(
        'February 14, 2010 16:14 PM CDT'
      )
      expect(output[0][:publisher]).to eq 'sportsnetwork.com'
      expect(output[0][:priority]).to eq 'normal'
      expect(output[0][:sport]).to eq '15031000'
      expect(output[0][:league]).to eq 'l.nhl.com'
      expect(output[0][:conference]).to eq 'c.western'
      expect(output[0][:team]).to eq 'l.nhl.com-t.19'
    end

    let(:input) do
      {
        sandbox: true,
        league_id: 'l.nhl.com',
        team_id: 'l.nhl.com-t.19',
        type: 'schedule-single-team',
        start_datetime: '2010-01-01 00:00:00 CDT',
        end_datetime: '2011-01-01 00:00:00 CDT'
      }
    end
    let(:output) { subject.content_finder(input) }

    it 'has seven items with string timestamp' do
      expect(output.length).to eq 7
    end

    it 'has attributes that match with string timestamp' do
      expect(output[1][:title]).to eq '2010 Nashville Predators Schedule'
      expect(output[1][:link]).to eq 'http://soda.xmlteam.com/api-trial/getDocuments?doc-ids=xt.10860136-nas-sked'
      expect(output[1][:document_id]).to eq 'xt.10860136-nas-sked'
      expect(output[1][:date]).to eq DateTime.parse(
        'February 12, 2010 22:49 PM CDT'
      )
      expect(output[1][:publisher]).to eq 'sportsnetwork.com'
      expect(output[1][:priority]).to eq 'normal'
      expect(output[1][:sport]).to eq '15031000'
      expect(output[1][:league]).to eq 'l.nhl.com'
      expect(output[1][:conference]).to eq 'c.western'
      expect(output[1][:team]).to eq 'l.nhl.com-t.19'
    end

  end

  describe '.get_document' do

    let(:input) do
      {
        sandbox: true,
        document_id: 'xt.10875359-nas-sked'
      }
    end
    let(:output) { subject.get_document(input) }

    it 'has one schedule node' do
      expect(output.css('schedule').length).to eq 1
    end

    it 'has 82 games in a season' do
      expect(output.css('schedule sports-event').length).to eq 82
    end

  end

end
