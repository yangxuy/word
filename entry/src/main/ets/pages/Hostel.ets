import { TitleComponent } from '../components/back'
import { request } from '../http/request'
import { promptAction } from '@kit.ArkUI'
import { UserInfo } from '../model/user';

@Entry
@Component
struct Hostel {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('user') user: UserInfo | undefined = undefined;
  private formData: ESObject = {}

  async submit() {
    await request.post("/dormitory/submit", this.formData)
    promptAction.showToast({
      message: '宿舍更换已申请',
      duration: 2000
    });
  }

  build() {
    Scroll() {
      Column({ space: 24 }) {
        TitleComponent({
          title: "宿舍更换申请"
        })

        Column({ space: 16 }) {
          Text("注意事项")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Row({ space: 8 }) {
            Image($r('app.media.zhuyi'))
              .width(20)
            Text("每学期仅可申请一次宿舍更换")
          }

          Row({ space: 8 }) {
            Image($r('app.media.zhuyi'))
              .width(20)
            Text("需提供充分的更换理由")
          }

          Row({ space: 8 }) {
            Image($r('app.media.zhuyi'))
              .width(20)
            Text("申请通过后需在 3 个工作日内完成搬迁")
          }
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor('#50eff6ff')

        Column({ space: 18 }) {
          Text("基本信息")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Column({ space: 18 }) {
            Row() {
              Text("学号：")
              Text(this.user?.studentNo)
            }

            Row() {
              Text("姓名：")
              Text(this.user?.studentName)
            }

            Row() {
              Text("院系：")
              Text(this.user?.studentDepart)
            }
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#f9fafb')
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("当前宿舍信息")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Column({ space: 18 }) {
            Row() {
              Text("宿舍楼：")
              Text("12号楼")
            }

            Row() {
              Text("房间号：")
              Text("516")
            }

            Row() {
              Text("床位号：")
              Text("3号床")
            }
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#f9fafb')
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("目标宿舍选择")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Column({ space: 18 }) {
            Row() {
              Text("宿舍楼：")
              TextInput()
                .borderRadius(12)
                .layoutWeight(1)
                .onChange((e) => {
                  this.formData.hostelBuildingNew = e
                })
            }

            Row() {
              Text("房间号：")
              TextInput()
                .borderRadius(12)
                .layoutWeight(1)
                .onChange((e) => {
                  this.formData.hostelRoomNew = e
                })
            }
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#f9fafb')
        }
        .alignItems(HorizontalAlign.Start)


        Column({ space: 18 }) {
          Text("更换原因")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)


          Row() {
            TextArea({ placeholder: '请详细说明申请更换宿舍的原因（不少于50字）' })
              .backgroundColor('#f9fafb')
              .layoutWeight(1)
              .borderRadius(12)
              .constraintSize({ minHeight: 90 })
              .onChange((e) => {
                this.formData.reason = e
              })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("舍友意见")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Row() {
            TextArea({ placeholder: '请填写现有舍友对此次调换的意见' })
              .backgroundColor('#f9fafb')
              .layoutWeight(1)
              .borderRadius(12)
              .constraintSize({ minHeight: 90 })
              .onChange((e) => {
                this.formData.roommateDesc = e
              })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("辅导员意见")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Row() {
            TextArea({ placeholder: '待辅导员审核后填写' })
              .backgroundColor('#f9fafb')
              .layoutWeight(1)
              .borderRadius(12)
              .constraintSize({ minHeight: 90 })
              .onChange((e) => {
                this.formData.counselorDesc = e
              })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Button("提交申请")
          .width('100%')
          .backgroundColor('#4f46e5')
          .onClick(() => {
            this.submit()
          })
      }
      .padding(16)
    }
  }
}