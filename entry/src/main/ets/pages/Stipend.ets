import { TitleComponent } from '../components/back'
import { request } from '../http/request'
import { promptAction } from '@kit.ArkUI'
import { UserInfo } from '../model/user';

@Entry
@Component
struct Stipend {
  @StorageProp('user') user: UserInfo | undefined = undefined;
  @StorageProp('topHeight') topHeight: number = 0
  private formData: ESObject = {}

  async submit() {
    await request.post("/stipend/submit", this.formData)
    promptAction.showToast({
      message: '助学金已申请',
      duration: 2000
    });
  }

  build() {
    Scroll() {
      Column({ space: 24 }) {
        TitleComponent({
          title: "助学金申请"
        })

        Column({ space: 18 }) {
          Text("国家助学金")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Text("¥ 4,000")
            .fontColor("#4f46e5")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Text("要求：家庭经济困难，生活费用存在困难")
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("临时困难补助")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Text("¥ 2,000")
            .fontColor("#4f46e5")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Text("要求：遭遇突发事件导致家庭经济困难")
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("勤工助学")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Text("¥ 8,00月")
            .fontColor("#4f46e5")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Text("要求：家庭经济困难，愿意参与校内勤工助学工作")
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("个人信息")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text("学号")
            Text(this.user?.studentNo)
          }

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text("姓名")
            Text(this.user?.studentName)
          }

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text("院系")
            Text(this.user?.studentDepart)
          }
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("家庭经济状况")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          Column({ space: 4 }) {
            Text("家庭年收入（元）")
            TextInput({ placeholder: "请输入家庭年收入" })
              .borderRadius(12)
              .onChange((e) => {
                this.formData.familyIncomeYear = e
              })
          }
          .alignItems(HorizontalAlign.Start)

          Column({ space: 4 }) {
            Text("家庭人口数")
            TextInput({ placeholder: "请输入家庭人口数" })
              .borderRadius(12)
              .onChange((e) => {
                this.formData.familySize = e
              })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("困难情况说明")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextArea({ placeholder: "请详细说明家庭经济困难情况" })
            .borderRadius(12)
            .constraintSize({ minHeight: 90 })
            .onChange((e) => {
              this.formData.poorDesc = e
            })
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("社会实践经历")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextArea({ placeholder: "请输入社会实践经历" })
            .borderRadius(12)
            .constraintSize({ minHeight: 90 })
            .onChange((e) => {
              this.formData.socialPractice = e
            })
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor('#fff')
        .alignItems(HorizontalAlign.Start)

        Button("提交申请")
          .width('100%')
          .backgroundColor('#4f46e5')
          .onClick(() => {
            this.submit()
          })
      }
      .width('100%')
      .backgroundColor('#f8fafc')
      .padding(16)
    }
  }
}