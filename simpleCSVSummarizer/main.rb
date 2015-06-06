# -*- coding: utf-8 -*-
require "json"

# Class Definitions
################################################################################
# CSVの１レコードに相当するタプルデータクラス
class Record
  attr_accessor :name,
                :kokugo,
                :sansuu,
                :rika

  # Constructor
  def initialize(name, kokugo, sansuu, rika)
    @name = name;
    @kokugo = kokugo;
    @sansuu = sansuu;
    @rika = rika;
  end

  # methods
  def total
    return @kokugo + @sansuu + @rika;
  end
end

# 集計結果を格納するコンテナクラス
class Result
  attr_accessor :topTotal, :average

  # 最高得点者を格納するコンテナ
  class TopTotal
    attr_accessor :name, :total

    # Constructor
    def initialize(record)
      @name = record.name;
      @total = record.total;
    end

    # methods
    def to_hash
      return {
        "name" => @name,
        "total" => @total
      };
    end
  end

  # 各教科ごとの平均点を格納するコンテナ
  class Average
    attr_accessor :kokugo, :sansuu, :rika

    # Constructor
    def initialize(kokugo, sansuu, rika)
      @kokugo = kokugo;
      @sansuu = sansuu;
      @rika = rika;
    end

    # methods
    def to_hash
      return {
        "kokugo" => @kokugo,
        "sansuu" => @sansuu,
        "rika" => @rika
      };
    end
  end

  # methods
  def to_hash
    return {
      "topTotal" => @topTotal.to_hash,
      "average" => @average.to_hash
    };
  end
end

# Sub Routines
################################################################################
# read CSV file and parse as Array of Record Object.
def readCSV(filePath)
  recordList = [];
  lineNumber = 0;
  File.open(filePath) {|f|
    f.each_line {|line|
      if 0 < lineNumber then
        fields = line.split(/\s*,\s*/);
        record = Record.new(fields[0],
                            Integer(fields[1]),
                            Integer(fields[2]),
                            Integer(fields[3]));
        recordList.push(record);
      end
      lineNumber += 1;
    }
  }
  return recordList;
end

# totalize the Array of Record Object.
def totalization(recordList)
  totalMax = 0;
  totalKokugo = 0;
  totalSansuu = 0;
  totalRika = 0;
  recordTemp = nil;
  for record in recordList do
    totalKokugo += record.kokugo;
    totalSansuu += record.sansuu;
    totalRika += record.rika;
    total = record.total;
    if totalMax < total then
      recordTemp = record;
    end
  end

  topTotal = Result::TopTotal.new(recordTemp);
  average = Result::Average.new(totalKokugo/recordList.size,
                                totalSansuu/recordList.size,
                                totalRika/recordList.size);
  result = Result.new;
  result.topTotal = topTotal;
  result.average = average;
  return result;
end

# Main Routine
################################################################################
recordList = readCSV("data.csv");
result = totalization(recordList);

puts JSON.pretty_generate(result.to_hash);
