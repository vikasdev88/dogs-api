const urlBuilder = (baseUrl, targetPath, params) => {
  return `${baseUrl}${targetPath}?${params}`
}
const GetFetchRequest = (path, params) => {
  const serverPath = location.href;
  const url = urlBuilder(serverPath, path, params);
  return fetch(url, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
      }
    })
}

export default GetFetchRequest
