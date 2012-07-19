class TasksController < ApplicationController
  respond_to :html, :json
  expose_parent :document, [:proposal, :experiencie, :category]
  expose(:tasks) { document.tasks }
  expose(:task)

  def new
  end

  def create
    task.save
    respond_with task, location: [document, :edition]
  end

  def update
    task.finished = !task.finished
    task.save
    respond_with task, location: [document, :edition]
  end
end