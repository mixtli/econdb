class StockExchangesController < ApplicationController
  # GET /stock_exchanges
  # GET /stock_exchanges.xml
  def index
    @stock_exchanges = StockExchange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stock_exchanges }
    end
  end

  # GET /stock_exchanges/1
  # GET /stock_exchanges/1.xml
  def show
    @stock_exchange = StockExchange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stock_exchange }
    end
  end

  # GET /stock_exchanges/new
  # GET /stock_exchanges/new.xml
  def new
    @stock_exchange = StockExchange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stock_exchange }
    end
  end

  # GET /stock_exchanges/1/edit
  def edit
    @stock_exchange = StockExchange.find(params[:id])
  end

  # POST /stock_exchanges
  # POST /stock_exchanges.xml
  def create
    @stock_exchange = StockExchange.new(params[:stock_exchange])

    respond_to do |format|
      if @stock_exchange.save
        flash[:notice] = 'StockExchange was successfully created.'
        format.html { redirect_to(@stock_exchange) }
        format.xml  { render :xml => @stock_exchange, :status => :created, :location => @stock_exchange }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stock_exchange.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stock_exchanges/1
  # PUT /stock_exchanges/1.xml
  def update
    @stock_exchange = StockExchange.find(params[:id])

    respond_to do |format|
      if @stock_exchange.update_attributes(params[:stock_exchange])
        flash[:notice] = 'StockExchange was successfully updated.'
        format.html { redirect_to(@stock_exchange) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stock_exchange.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_exchanges/1
  # DELETE /stock_exchanges/1.xml
  def destroy
    @stock_exchange = StockExchange.find(params[:id])
    @stock_exchange.destroy

    respond_to do |format|
      format.html { redirect_to(stock_exchanges_url) }
      format.xml  { head :ok }
    end
  end
end
