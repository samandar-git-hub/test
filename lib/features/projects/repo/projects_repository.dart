class ProjectItem {
  final String id;
  final String name;
  final String template;
  final String device;
  final String date;
  final String elements;

  ProjectItem({
    required this.id,
    required this.name,
    required this.template,
    required this.device,
    required this.date,
    required this.elements,
  });
}

class ProjectsRepository {
  static final List<ProjectItem> myProjects = [
    ProjectItem(
      id: 'proj_1',
      name: 'Chop etish ilovasi',
      template: 'login',
      device: 'iPhone 17 Pro',
      date: 'Bugun, 10:15',
      elements: '6 ta element',
    ),
    ProjectItem(
      id: 'proj_2',
      name: 'Online do\'kon UI',
      template: 'dashboard',
      device: 'Samsung Galaxy S26',
      date: 'Kecha, 18:40',
      elements: '5 ta element',
    ),
    ProjectItem(
      id: 'proj_3',
      name: 'Profil sozlamalari',
      template: 'profile',
      device: 'iPhone 17 Pro',
      date: '12-iyun, 14:02',
      elements: '5 ta element',
    ),
  ];
}
