import axios from '@ohos/axios'

export const request = axios.create({
  baseURL: "http://47.113.115.76:9000"
})

request.interceptors.request.use((config: ESObject) => {
  const student: ESObject = AppStorage.get("user")
  config.data.studentName = student.studentName
  config.data.studentNo = student.studentNo
  config.data.studentDepart = student.studentDepart
  return config
}, (err: ESObject) => {
  console.log('interceptors request err:', JSON.stringify(err))
})

request.interceptors.response.use((response: ESObject) => {
  return response
}, (err: ESObject) => {
  console.log('interceptors response err:', JSON.stringify(err))
})