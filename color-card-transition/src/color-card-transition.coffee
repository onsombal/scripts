ws_id = null; color = null; color_name = null

$(window.board.model.attributes.workflow_stages).each (i, e) =>
  ws_id = e.id if e.name && (/\*T\*/g).test(e.name)

$(window.board.model.attributes.card_types).each (i, e) =>
  if e.name && (/\*T\*/g).test(e.name)
    color = e.id
    color_name = e.color_ref

# Iterate all tasks on board
taskIterator = () =>
  window.board.tasks.forEach (task) =>
    checkTask(task)

# Check task
checkTask = (task) =>
  # If task is in selected for CCT column and isn't changed
  if task.model.attributes.workflow_stage_id == parseInt(ws_id) && !$(task.el).hasClass('cct')
    updated_at = moment(task.model.attributes.updated_at)
    # Check that staying longer than 30 minutes
    if moment().diff(updated_at, 'minutes') > 30
      $(task.el).removeClass(task.model.attributes.card_color).addClass(color_name).addClass('cct')
      isInvert(task, color_name)

# Back to base color
moveTask = (task) =>
  task_attrs = task.model.attributes
  if task_attrs.workflow_stage_id != parseInt(ws_id) && $(task.el).hasClass('cct')
    $(task.el).removeClass(color_name).addClass(task_attrs.card_color).removeClass('cct')
    isInvert(task, task_attrs.card_color)

# Check that color require invert class
isInvert = (task, color) =>
  is_invert = true if $.inArray(color, ['navy','green_dark','brown','gray_medium','gray_dark','black']) >= 0
  if is_invert
    $(task.el).addClass('invert')
  else
    $(task.el).removeClass('invert')

# If column and color was selected
if color && ws_id
  setTimeout(taskIterator, 500)
  setTimeout(taskIterator, 2000)
  setInterval(taskIterator, 50000)
  window.board.on('task:render', moveTask);