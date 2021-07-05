//
//  NewsTVC.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit
import Foundation

class NewsTVC: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    var news : [Event] = [Event.init("ACADEMIC SKILLS PREPARATION COURSE", "The Academic Skills course is aiming at an earlier immersion of high school graduates, would-be Bachelor students in the academic environment. The course is designed for those who would like to master their learning competencies, to get familiarized with main aspects of studying at university, and to acquire basic skills for effective academic activities. As the language of instruction is English, listening, reading, writing, and speaking skills in the target language will be improved. As part of the program, course takers will participate in lectures, seminars, and tutorials, where they will learn how to set goals, increase confidence when speaking, develop interpersonal communication skills. The course takers will also get acquainted with the online platforms used in KBTU for academic goals achievement, for the learning materials storage, and for measuring students’ academic performan"), Event.init("REPUBLICAN SUBJECT OLYMPIAD KBTU!", "Dear students and college graduates! We are pleased to announce to you the holding of the KBTU Republican Subject Olympiad among among students in grades 10-12 and college graduates! (citizens of the Republic of Kazakhstan). The Olympiad will be held in five areas: - Information and communication technologies - Business and management - Manufacturing and processing industries - Marine transport and technology - Chemical engineering and processes. The winners of the Olympiad will receive GRANTS and DISCOUNTS for studying at KBTU! Format: Online. Round 1: March 11, 2021. Round 2: March 17, 2021. You can read the terms and conditions in the Olympiad Regulations."), Event.init("SCHOLARSHIP NAMED AFTER ACADEMICIAN SHAKHMARDAN YESSENOV 2021", "Scientific and educational foundation named after Academician Shakhmardan Yessenov announces a competition for the provision of 17 monthly student scholarships for 27,000 tenge. Participants of the program: students, citizens of Kazakhstan over 18 years old, studying at Kazakh universities for 2-3 courses of bachelor's degree or 1st year of master's degree and 1st year of internship in natural science, technical, medical and IT specialties. Number of grants: 17"), Event.init("BEST UNIVERSITY TEACHER 2020", "Teachers of KBTU Isakhov Asylbek Abdiashimovich and Kulpeshov Beibut Shaiykovich became the holders of the title “The best teacher of the university 2020”! 623 applicants from 73 higher educational institutions of the republic took part in the competition. The activities of teachers were assessed according to the updated qualitative and quantitative indicators of assessing the work of applicants, consisting of two blocks: I block - the quality of teaching, II block - research activities. For the first time this year, in order to exclude subjectivity, applications for participation in the competition “The best teacher of the university-2020”, the procedure for checking documents, as well as an appeal, were carried out through the information system of the MES RoK online. Isakhov Asylbek Abdiashimovich and Kulpeshov Beibut Shaiykovich are professors of the Scientific and Educational Center of Mathematics and Cybernetics of KBTU. In addition to professorship, Asylbek Isakhov holds the position of dean of this faculty. Congratulations!")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell 
        cell?.discription.text = news[indexPath.row].discription
        cell?.title.text = news[indexPath.row].title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
