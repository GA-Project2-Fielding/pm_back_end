Collaborator.destroy_all
User.destroy_all
Project.destroy_all

# Creating two Users
User.create([{user_name: 'bbob', email: 'fake@fake.com', first_name: 'Bill', last_name: 'Bob', password: 'Kitty', token: 'token'}, {user_name: 'ab111', email: 'not@real.com', first_name: 'Brad', last_name: 'Pitt', password: 'password', token: 'token'}])

# Creating two Projects, one for each user
User.all[0].projects.create(project_title: 'makin cakes', start_date: DateTime.now)
User.all[1].projects.create(project_title: 'eatin them too', start_date: DateTime.now)

# Creating two parent tasks for first project
Project.first.tasks.create(title: 'patty cake', due_date: DateTime.now)
Project.first.tasks.create(title: 'patty cake', due_date: DateTime.now)

# Creating one child tasks for the first project's first task
# id = Project.first.project_id
# Project.first.tasks.first.subtasks.create(title: "Baker's flippin man!", due_date: DateTime.now, project_id: id)

Project.first.tasks.first.create_subtask("WORKKKKKK!")

# Creating one child task for the above child task
# Project.all[0].tasks.all[0].subtasks.all[0].create(title: "BAKE ME THAT DAMN CAKE!!", due_date: DateTime.now)
