# frozen_string_literal: true

class Position
  # マスを'f3','d6'などの表記で表現する。変数名cell_refとして取り扱う。
  COL = %w[a b c d e f g h].freeze
  ROW = %w[1 2 3 4 5 6 7 8].freeze

  DIRECTIONS = [
    TOP_LEFT      = :top_left,
    TOP           = :top,
    TOP_RIGHT     = :top_right,
    LEFT          = :left,
    RIGHT         = :right,
    BOTTOM_LEFT   = :bottom_left,
    BOTTOM        = :bottom,
    BOTTOM_RIGHT  = :bottom_right
  ].freeze

  attr_accessor :row, :col #attr_accessorメソッドを使うと、クラス外部からインスタンス変数へのアクセスが可能になる。

  def initialize(row_or_cell_ref, col = nil) #位置の呼び出し？
    if col
      # Position.new(1, 5) のような呼び出し
      @row = row_or_cell_ref
      @col = col
    else
      # Position.new('f7')のような呼び出し
      @row = ROW.index(row_or_cell_ref[1])
      @col = COL.index(row_or_cell_ref[0])
    end
  end

  def invalid? #位置が無効(エラー)だった場合にtrueを返す
    #binding.break
    row.nil? || col.nil?
  end

  def out_of_board? #ボード外に位置している場合に true を返す
    !((0..7).cover?(row) && (0..7).cover?(col))
  end

  def stone_color(board) #引数としてボードを受け取り現在の位置にある石の色を返す。位置がボード外の場合は nil を返す。
    return nil if out_of_board?

    board[row][col]
  end

  def to_cell_ref #位置をセルの参照形式の(例"f7"")文字列に変換して返す。ボード外の場合は '盤面外' を返す。
    return '盤面外' if out_of_board?

    "#{COL[col]}#{ROW[row]}"
  end

  def next_position(direction)
    case direction
    when TOP_LEFT     then Position.new(row - 1, col - 1)
    when TOP          then Position.new(row - 1, col)
    when TOP_RIGHT    then Position.new(row - 1, col + 1)
    when LEFT         then Position.new(row,     col - 1)
    when RIGHT        then Position.new(row,     col + 1)
    when BOTTOM_LEFT  then Position.new(row + 1, col - 1)
    when BOTTOM       then Position.new(row + 1, col)
    when BOTTOM_RIGHT then Position.new(row + 1, col + 1)
    else raise 'Unknown direction'
    end
  end
end
