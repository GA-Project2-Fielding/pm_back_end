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
Project.first.tasks.first.seed_subtask(DateTime.now, 'Bakers Man!')

# Creating one child task for the above child task
Project.first.tasks.first.subtasks.first.seed_subtask(DateTime.now, 'Bake me da cake!!!')
