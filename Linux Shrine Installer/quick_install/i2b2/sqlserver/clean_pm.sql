-- This is the SHRINE user and PROJECT

delete from PM_USER_DATA          where user_id      = 'SHRINE_USER';
delete from PM_USER_PARAMS        where user_id      = 'SHRINE_USER';
delete from PM_PROJECT_DATA       where project_name = 'SHRINE';
delete from PM_PROJECT_USER_ROLES where project_id   = 'SHRINE';
delete from PM_CELL_DATA          where project_path = '/SHRINE';
