module.exports = {
  excludes: ['./public/**'],
  emptyLineBetweenGroups: true,
  sortImports: true,
  groupImports: true,
  minimumVersion: '4.0.2',
  namedExports: {
    'react-router-dom': [
      'Link',
      'NavLink',
      'BrowserRouter',
      'Route',
      'Redirect',
      'Switch',
      'Redirect',
      'useParams',
      'useHistory'
    ]
  }
};
