import 'package:flutter/material.dart';
import 'package:graduation_project/features/shared/data/domain/entities/candidate_entity.dart';

class CandidateRichCard extends StatefulWidget {
  final CandidateEntity candidate;
  final Color primaryColor;
  final bool initialIsBookmarked;
  final Function(bool) onBookmarkToggle;
  final VoidCallback onTap;

  const CandidateRichCard({
    super.key,
    required this.candidate,
    required this.primaryColor,
    required this.initialIsBookmarked,
    required this.onBookmarkToggle,
    required this.onTap, // ✅ مطلوب في الـ Constructor
  });

  @override
  State<CandidateRichCard> createState() => _CandidateRichCardState();
}

class _CandidateRichCardState extends State<CandidateRichCard> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.initialIsBookmarked;
  }

  void didUpdateWidget(covariant CandidateRichCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIsBookmarked != oldWidget.initialIsBookmarked) {
      setState(() {
        isBookmarked = widget.initialIsBookmarked;
      });
    }
  }

  void _handleBookmarkTap() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
    widget.onBookmarkToggle(isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> skillsList =
        (widget.candidate.skills != null && widget.candidate.skills!.isNotEmpty)
        ? widget.candidate.skills!.split(',').map((e) => e.trim()).toList()
        : [];

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Avatar ---
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.primaryColor.withOpacity(0.1),
                      image: widget.candidate.avatarUrl != null
                          ? DecorationImage(
                              image: NetworkImage(widget.candidate.avatarUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: widget.candidate.avatarUrl == null
                        ? Center(
                            child: Text(
                              widget.candidate.fullName.isNotEmpty
                                  ? widget.candidate.fullName[0].toUpperCase()
                                  : "?",
                              style: TextStyle(
                                color: widget.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),

                  // --- Info ---
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.candidate.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.candidate.jobTitle ?? "Open to Work",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _handleBookmarkTap,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isBookmarked
                              ? widget.primaryColor.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.05),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            key: ValueKey(isBookmarked),
                            color: isBookmarked
                                ? widget.primaryColor
                                : Colors.grey[400],
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // --- Skills ---
              if (skillsList.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skillsList.take(3).map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 12),

              // --- Footer ---
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.candidate.city ?? "Remote",
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  Text(
                    "View Profile",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: widget.primaryColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: widget.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
