class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html
      format.json { render :json => @transactions }
    end
  end

  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @transaction }
    end
  end

  def new
    @transaction = Transaction.new
    respond_to do |format|
      format.html
      format.json { render :json => @transaction }
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @accounts = current_user.accounts.all
  end

  def create
    @transaction = current_user.transactions.build(params[:transaction])
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, :notice => 'Transaction was successfully created.' }
        format.json { render :json => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :new }
        format.json { render :json => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to @transaction, :notice => 'Transaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :ok }
    end
  end
end
